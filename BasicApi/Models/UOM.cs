using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceAPI.Models
{
    public class UOM
    {
        public string uom_code { get; set; }
        public string unit_of_measurement { get; set; }
        public string Message { get; set; } = "";
    }
}
