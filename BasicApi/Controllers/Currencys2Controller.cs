using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

using InvoiceAPI.IService;
using InvoiceAPI.Models;

namespace InvoiceAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class Currencys2Controller : ControllerBase
    {
        private Icurrency2Service _oicurrency2Service;

        public Currencys2Controller(Icurrency2Service oicurrency2Service)
        {
            _oicurrency2Service = oicurrency2Service;
        }

        // GET: api/<InvoicesController>
        [HttpGet]
        public async Task<IEnumerable<Currency>> GetAllCurrency()
        {
            return await _oicurrency2Service.GetAll();
        }
    }
}
