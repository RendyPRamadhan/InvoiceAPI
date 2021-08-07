using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using InvoiceAPI.Models;

namespace InvoiceAPI.Repository
{
   public interface ICurrencyService
    {
        Task<List<Currency>> GetCurrencys();
    }
}
