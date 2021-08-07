using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using InvoiceAPI.IService;
using InvoiceAPI.Models;
using InvoiceAPI.Repository;

namespace InvoiceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CurrencysController : ControllerBase
    {
        private ICurrencyService _oCurrencyService;

        public CurrencysController(ICurrencyService oCurrencyService)
        {
            _oCurrencyService = oCurrencyService;
        }

        // GET: api/<Controller>
        [HttpGet]
        public async Task<IEnumerable<Currency>> GetAllCurrency()
        {
            return await _oCurrencyService.GetCurrencys();
        }
    }
}
