using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using InvoiceAPI.Models;

namespace InvoiceAPI.IService
{
    public interface IUOMService
    {
        Task<List<UOM>> GetUOMs();
    }
}
