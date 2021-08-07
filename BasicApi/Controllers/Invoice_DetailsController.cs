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
    public class Invoice_DetailsController : ControllerBase
    {
        private IInvoice_DetailService _oInvoice_DetailsService;

        public Invoice_DetailsController(IInvoice_DetailService oInvoice_detailService)
        {
            _oInvoice_DetailsService = oInvoice_detailService;
        }
        public async Task<Invoice_Detail> Post([FromBody] Invoice_Detail oInvoice_Detail)
        {
            return await _oInvoice_DetailsService.CMD_Invoice_Detail(oInvoice_Detail);
        }
        // GET api/<Invoice_DetailsController>/5
        [HttpGet("{Invoice_no}")]
        public async Task<Invoice_Detail> GetByInvoiceNo(string Invoice_no)
        {
            return await _oInvoice_DetailsService.GetByInvoiceNo(Invoice_no);
        }
    }
}
