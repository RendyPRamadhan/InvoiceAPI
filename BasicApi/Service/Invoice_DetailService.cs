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
    public class Invoice_DetailService : IInvoice_DetailService
    {
        Invoice_Detail _oInvoice = new Invoice_Detail();
        List<Invoice_Detail> _oInvoices = new List<Invoice_Detail>();

        SqlConnection sqlCon = null;
        SqlCommand sqlCom = null;

        public Invoice_DetailService(IConfiguration configuration)
        {
            sqlCon = new SqlConnection(configuration.GetConnectionString("DB_KALBE"));
        }

        public async Task<Invoice_Detail> CMD_Invoice_Detail(Invoice_Detail oInvoice_Detail)
        {
            _oInvoice = new Invoice_Detail();
            try
            {
                sqlCon.Open();
                sqlCom = new SqlCommand("SP_CMD_INVOICE_DETAIL", sqlCon);
                sqlCom.CommandType = CommandType.StoredProcedure;
                sqlCom = this.SetParameters(sqlCom, oInvoice_Detail);
                sqlCon.Close();

                sqlCon.Open();
                SqlDataReader reader = await sqlCom.ExecuteReaderAsync();
                //while (reader.Read()) _oInvoice = this.Mapping(reader);
            }
            catch (Exception ex)
            {
                _oInvoice = new Invoice_Detail() { Message = ex.Message.Split('~')[0] };
            }
            finally
            {
                sqlCom.Dispose();
                sqlCon.Close();
            }
            return _oInvoice;
        }
        public async Task<Invoice_Detail> GetByInvoiceNo(string nInvoiceNo)
        {
            _oInvoice = new Invoice_Detail();
            try
            {
                sqlCon.Open();
                sqlCom = new SqlCommand("SELECT * FROM VW_INVOICE_DETAIL WHERE invoice_no = '" + nInvoiceNo + "'", sqlCon);
                SqlDataReader reader = await sqlCom.ExecuteReaderAsync();
                while (reader.Read()) _oInvoice = this.Mapping_SelectInvoice_Detail(reader);
            }
            catch (Exception ex)
            {
                _oInvoice = new Invoice_Detail() { Message = ex.Message.Split('~')[0] };
            }
            finally
            {
                sqlCom.Dispose();
                sqlCon.Close();
            }
            return _oInvoice;
        }

        private Invoice_Detail Mapping_SelectInvoice_Detail(SqlDataReader reader)
        {
            return new Invoice_Detail()
            {
                invoice_no = reader["invoice_no"].ToString(),
                name = reader["name"].ToString(),
                quantity = (int)reader["quantity"],
                rate = (decimal)reader["rate"],
                unit_of_measurement = reader["unit_of_measurement"].ToString(),
                amount = (Decimal)reader["amount"],
                seq = (int)reader["seq"],
                currency = reader["currency"].ToString(),

            };
        }

        public SqlCommand SetParameters(SqlCommand sqlCom, Invoice_Detail oInvoice)
        {
            sqlCom.Parameters.AddWithValue("@Query", oInvoice.query);
            sqlCom.Parameters.AddWithValue("@Invoice_no", oInvoice.invoice_no);
            sqlCom.Parameters.AddWithValue("@Name", oInvoice.name);
            sqlCom.Parameters.AddWithValue("@Quantity", oInvoice.quantity);
            sqlCom.Parameters.AddWithValue("@Rate", oInvoice.rate);
            sqlCom.Parameters.AddWithValue("@Amount", oInvoice.amount);
            sqlCom.Parameters.AddWithValue("@Unit_of_measurement", oInvoice.unit_of_measurement);
            sqlCom.Parameters.AddWithValue("@seq", oInvoice.seq);
            sqlCom.Parameters.AddWithValue("@Currency", oInvoice.currency);
            return sqlCom;
        }
    }
}
