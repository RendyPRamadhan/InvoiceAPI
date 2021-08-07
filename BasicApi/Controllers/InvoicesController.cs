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
    public class InvoicesController : ControllerBase
    {
        private IInvoiceService _oInvoicesService;

        public InvoicesController(IInvoiceService oInvoiceService)
        {
            _oInvoicesService = oInvoiceService;
        }

        // GET: api/<InvoicesController>
        [HttpGet]
        public async Task<IEnumerable<Invoice>> GetAllInvoices()
        {
            return await _oInvoicesService.GetAll();
        }
        public async Task<Invoice> Post([FromBody] Invoice oInvoice)
        {
            return await _oInvoicesService.CMD_Invoice(oInvoice);
        }
        // GET api/<InvoicesController>/5
        [HttpGet("{Invoice_no}")]
        public async Task<Invoice> GetByInvoiceNo(string Invoice_no)
        {
            return await _oInvoicesService.GetByInvoiceNo(Invoice_no);
        }

        //[HttpGet("{Invoice_no}")]
        /*
        public async Task<Invoice> GetById_Detail(string Invoice_no)
        {
            return await _oInvoicesService.GetById_Head(Invoice_no);
        }
        */
        
    }
   
}
