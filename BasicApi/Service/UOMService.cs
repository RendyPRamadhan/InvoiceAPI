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
    public class UOMService : IUOMService
    {
        UOM _oUOM = new UOM();
        List<UOM> _oUOMs = new List<UOM>();

        SqlConnection sqlCon = null;
        SqlCommand sqlCom = null;

        public UOMService(IConfiguration configuration)
        {
            sqlCon = new SqlConnection(configuration.GetConnectionString("DB_KALBE"));
        }

        public async Task<List<UOM>> GetUOMs()
        {
            _oUOMs = new List<UOM>();
            try
            {
                sqlCon.Open();
                sqlCom = new SqlCommand("SELECT * FROM tbl_unit_of_measurement", sqlCon);
                SqlDataReader reader = await sqlCom.ExecuteReaderAsync();
                while (reader.Read()) _oUOMs.Add(this.Mapping(reader));
            }
            catch (Exception ex)
            {
                _oUOMs = new List<UOM>();
                _oUOMs.Add(new UOM() { Message = ex.Message.Split('~')[0] });
            }
            finally
            {
                sqlCom.Dispose();
                sqlCon.Close();
            }
            return _oUOMs;
        }

        private UOM Mapping(SqlDataReader reader)
        {
            return new UOM()
            {
                uom_code = reader["uom_code"].ToString(),
                unit_of_measurement = reader["unit_of_measurement"].ToString(),
            };
        }
    }
}
