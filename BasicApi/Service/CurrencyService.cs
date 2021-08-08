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
    public class CurrencyService : ICurrencyService
    {
        Currency _oCurrncy = new Currency();
        List<Currency> _oCurrncys = new List<Currency>();

        SqlConnection sqlCon = null;
        SqlCommand sqlCom = null;

        public CurrencyService(IConfiguration configuration)
        {
            sqlCon = new SqlConnection(configuration.GetConnectionString("DB_KALBE"));
        }

        public async Task<List<Currency>> GetCurrencys()
        {
            _oCurrncys = new List<Currency>();
            try
            {
                sqlCon.Open();
                sqlCom = new SqlCommand("SELECT * FROM tbl_Currency", sqlCon);
                SqlDataReader reader = await sqlCom.ExecuteReaderAsync();
                while (reader.Read()) _oCurrncys.Add(this.Mapping(reader));
            }
            catch (Exception ex)
            {
                _oCurrncys = new List<Currency>();
                _oCurrncys.Add(new Currency() { Message = ex.Message.Split('~')[0] });
            }
            finally
            {
                sqlCom.Dispose();
                sqlCon.Close();
            }
            return _oCurrncys;
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
