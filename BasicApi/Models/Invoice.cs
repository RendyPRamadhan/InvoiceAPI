using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceAPI.Models
{
    public class Invoice
    {
        public string query { get; set; } = "";
        public string invoice_no { get; set; } = "";
        public string language { get; set; } = "";
        public int language_id { get; set; } = 0;
        public string from { get; set; } = "";
        public string to { get; set; } = "";
        public string invoice_date { get; set; } 
        public string invoice_due { get; set; }
        public string po_number { get; set; } = "";
        public Decimal subtotal { get; set; } = 0;

        public string discount_desc { get; set; } = "";
        public Decimal discount { get; set; } = 0;
        public Decimal total { get; set; } = 0;
        public string currency { get; set; } = "";
        public string curr_desc { get; set; } = "";

        //table lain
        public string Message { get; set; } = "";
        public string company_name { get; set; } = "";
        public string address { get; set; } = "";
        public string subdistrict { get; set; } = "";
        public string city { get; set; } = "";
        public string country { get; set; } = "";
        public string logo { get; set; } = "";


        public int seq { get; set; } = 0;
        public string name { get; set; } = "";
        public Decimal quantity { get; set; } = 0;
        public Decimal rate { get; set; } = 0;
        public Decimal amount { get; set; } = 0;
        public string unit_of_measurement { get; set; } = "";
    }
}
