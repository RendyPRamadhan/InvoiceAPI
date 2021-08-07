using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using InvoiceAPI.IService;
using InvoiceAPI.Models;
using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace InvoiceAPI.Service
{
    public class InvoiceService : IInvoiceService
    {
        Invoice _oInvoice = new Invoice();
        List<Invoice> _oInvoices = new List<Invoice>();

        SqlConnection sqlCon = null;
        SqlCommand sqlCom = null;

        public InvoiceService(IConfiguration configuration)
        {
            sqlCon = new SqlConnection(configuration.GetConnectionString("DB_KALBE"));
        }
        public async Task<List<Invoice>> GetAll()
        {
            _oInvoices = new List<Invoice>();
            try
            {
                sqlCon.Open();
                sqlCom = new SqlCommand("SELECT * FROM VW_HOME_INVOICE", sqlCon);
                SqlDataReader reader = await sqlCom.ExecuteReaderAsync();
                while (reader.Read()) _oInvoices.Add(this.Mapping_SelectInvoice(reader));
            }
            catch (Exception ex)
            {
                _oInvoices = new List<Invoice>();
                _oInvoices.Add(new Invoice() { Message = ex.Message.Split('~')[0] });
            }
            finally
            {
                sqlCom.Dispose();
                sqlCon.Close();
            }
            return _oInvoices;
        }
        public async Task<Invoice> CMD_Invoice(Invoice oInvoice)
        {
            _oInvoice = new Invoice();
            try
            {
                sqlCon.Open();
                //sqlCom = new SqlCommand("SP_CMD_INVOICE_HEAD", sqlCon);
                sqlCom = new SqlCommand("SP_CMD_INVOICE_HEAD", sqlCon);
                sqlCom.CommandType = CommandType.StoredProcedure;
                sqlCom = this.SetParameters(sqlCom, oInvoice);
                sqlCon.Close();

                sqlCon.Open();
                SqlDataReader reader = await sqlCom.ExecuteReaderAsync();
                //while (reader.Read()) _oInvoice = this.Mapping(reader);
            }
            catch (Exception ex)
            {
                _oInvoice = new Invoice() { Message = ex.Message.Split('~')[0] };
            }
            finally
            {
                sqlCom.Dispose();
                sqlCon.Close();
            }
            return _oInvoice;
        }
        public async Task<Invoice> GetByInvoiceNo(string nInvoiceNo)
        {
            _oInvoice = new Invoice();
            try
            {
                sqlCon.Open();
                sqlCom = new SqlCommand("SELECT * FROM VW_HOME_INVOICE WHERE invoice_no = '" + nInvoiceNo + "'", sqlCon);
                SqlDataReader reader = await sqlCom.ExecuteReaderAsync();
                while (reader.Read()) _oInvoice = this.Mapping_SelectInvoice(reader);
            }
            catch (Exception ex)
            {
                _oInvoice = new Invoice() { Message = ex.Message.Split('~')[0] };
            }
            finally
            {
                sqlCom.Dispose();
                sqlCon.Close();
            }
            return _oInvoice;
        }
        /*
        public async Task<Invoice> GetById_Detail(string nInvoiceNo)
        {
            _oInvoice = new Invoice();
            try
            {
                sqlCon.Open();
                sqlCom = new SqlCommand("SELECT * FROM tbl_Invoice_Detail WHERE invoice_no = " + nInvoiceNo, sqlCon);
                SqlDataReader reader = await sqlCom.ExecuteReaderAsync();
                while (reader.Read()) _oInvoice = this.Mapping_SelectInvoice_Detail(reader);
            }
            catch (Exception ex)
            {
                _oInvoice = new Invoice() { Message = ex.Message.Split('~')[0] };
            }
            finally
            {
                sqlCom.Dispose();
                sqlCon.Close();
            }
            return _oInvoice;
        }
        */
       

        private Invoice Mapping(SqlDataReader reader)
        {
            return new Invoice()
            {
                invoice_no = reader["invoice_no"].ToString(),
                /*from = reader["from"].ToString(),
                //to = reader["to"].ToString(),
                company_name = reader["company_name"].ToString(),
                invoice_date = (DateTime)reader["invoice_date"],
                invoice_due = (DateTime)reader["invoice_due"],
                po_number = reader["po_number"].ToString(),
                subtotal = (Decimal)reader["subtotal"],
                discount = (Decimal)reader["discount"],
                total = (Decimal)reader["total"]*/
            };
        }

        private Invoice Mapping_SelectInvoice(SqlDataReader reader)
        {
            return new Invoice()
            {
                invoice_no = reader["invoice_no"].ToString(),
                language = reader["language"].ToString(),
                from = reader["from"].ToString(),
                to = reader["to"].ToString(),
                //invoice_date = (DateTime)reader["invoice_date"],
                //invoice_due = (DateTime)reader["invoice_due"],
                invoice_date = reader["invoice_date"].ToString(),
                invoice_due = reader["invoice_due"].ToString(),
                po_number = reader["po_number"].ToString(),
                subtotal = (Decimal)reader["subtotal"],
                discount_desc = reader["discount_desc"].ToString(),
                discount = (Decimal)reader["discount"],
                total = (Decimal)reader["total"],
                currency = reader["currency"].ToString(),

                company_name = reader["company_name"].ToString(),
                address = reader["address"].ToString(),
                subdistrict = reader["subdistrict"].ToString(),
                city = reader["city"].ToString(),
                country = reader["country"].ToString(),
                logo = reader["logo"].ToString(),
                
                //curr_desc = reader["curr_desc"].ToString(),
                //language_id = (int)reader["language_id"],

                
               
            };
        }
       private Invoice Mapping_SelectInvoice_Detail(SqlDataReader reader)
       {
            return new Invoice()
            {
                invoice_no = reader["invoice_no"].ToString(),
                name = reader["name"].ToString(),
                quantity = (Decimal)reader["quantity"],
                rate = (decimal) reader["rate"],
                unit_of_measurement = reader["unit_of_measurement"].ToString(),
                amount = (Decimal)reader["amount"],
                seq = (int)reader["seq"],
                currency = reader["currency"].ToString(),

            };
       }

            public SqlCommand SetParameters(SqlCommand sqlCom, Invoice oInvoice)
        {
            sqlCom.Parameters.AddWithValue("@Query", oInvoice.query);
            sqlCom.Parameters.AddWithValue("@InvoiceNo", oInvoice.invoice_no);
            sqlCom.Parameters.AddWithValue("@From", oInvoice.from);
            sqlCom.Parameters.AddWithValue("@To", oInvoice.to);
            sqlCom.Parameters.AddWithValue("@Invoice_date", oInvoice.invoice_date);
            sqlCom.Parameters.AddWithValue("@Invoice_due", oInvoice.invoice_due);
            sqlCom.Parameters.AddWithValue("@PO_number", oInvoice.po_number);
            sqlCom.Parameters.AddWithValue("@Subtotal", oInvoice.subtotal);
            sqlCom.Parameters.AddWithValue("@Discount_desc", oInvoice.discount_desc);
            sqlCom.Parameters.AddWithValue("@Discount", oInvoice.discount);
            sqlCom.Parameters.AddWithValue("@Total", oInvoice.total);
            sqlCom.Parameters.AddWithValue("@Currency", oInvoice.currency);
            return sqlCom;
        }
    }
}
