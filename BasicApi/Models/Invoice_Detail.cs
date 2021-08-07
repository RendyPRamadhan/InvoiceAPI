using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceAPI.Models
{
    public class Invoice_Detail
    {
        public string invoice_no { get; set; }
        public string name { get; set; }
        public int quantity { get; set; }
        public decimal rate { get; set; }
        public decimal amount { get; set; }
        public string unit_of_measurement { get; set; }
        public int seq { get; set; }
        public string currency { get; set; }
        public string Message { get; set; } = "";
        public string query { get; set; }

    }
}
