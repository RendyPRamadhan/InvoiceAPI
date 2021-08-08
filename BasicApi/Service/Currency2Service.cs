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
    public class Currency2Service : Icurrency2Service
    {
        Currency _oCurrency2 = new Currency();
        List<Currency> _oCurrencys2 = new List<Currency>();

        SqlConnection sqlcon = null;
        SqlCommand sqlcom = null;

        public Currency2Service(IConfiguration configuration)
        {
            sqlcon = new SqlConnection(configuration.GetConnectionString("DB_KALBE"));
        }

        public async Task<List<Currency>> GetAll()
        {
            _oCurrencys2 = new List<Currency>();
            try
            {
                sqlcon.Open();
                sqlcom = new SqlCommand("SELECT * FROM tbl_Currency", sqlcon);
                SqlDataReader reader = await sqlcom.ExecuteReaderAsync();
                while (reader.Read()) _oCurrencys2.Add(this.Mapping(reader));
            }
            catch (Exception ex)
            {
                _oCurrencys2 = new List<Currency>();
                _oCurrencys2.Add(new Currency() { Message = ex.Message.Split('~')[0] });
            }
            finally
            {
                sqlcom.Dispose();
                sqlcon.Close();
            }
            return _oCurrencys2;

        }
        private Currency Mapping(SqlDataReader reader)
        {
            return new Currency()
            {
                currency_id = (int)reader["currency_id"],
                currency = reader["currency"].ToString(),
                curr_desc = reader["curr_desc"].ToString(),
            };
        }

    }
}
