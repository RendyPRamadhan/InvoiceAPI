using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InvoiceAPI.Models
{
    public class Currency
    {
        public int currency_id { get; set; }
        public string currency { get; set; }
        public string curr_desc { get; set; }
        public string Message { get; set; } = "";
    }
}
