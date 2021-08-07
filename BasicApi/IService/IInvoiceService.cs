using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using InvoiceAPI.Models;

namespace InvoiceAPI.IService
{
    public interface IInvoiceService
    {
        Task<List<Invoice>> GetAll();
        Task<Invoice> CMD_Invoice(Invoice oInvoice);
        Task<Invoice> GetByInvoiceNo(string nInvoiceNo);
        

        //Task<Invoice> GetById_Detail(string nInvoiceNo);

        // Task<Invoice> AddOrUpdate(Invoice oInvoice);
        // Task<string> Delete(int nInvoiceNo);
    }
}
