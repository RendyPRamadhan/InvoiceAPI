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
    public class UOMsController : ControllerBase
    {
        private IUOMService _oUOMService;

        public UOMsController(IUOMService oUOMService)
        {
            _oUOMService = oUOMService;
        }

        // GET: api/<Controller>
        [HttpGet]
        public async Task<IEnumerable<UOM>> GetAllUOM()
        {
            return await _oUOMService.GetUOMs();
        }
    }
}
