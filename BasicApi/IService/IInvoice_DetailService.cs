using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

using InvoiceAPI.Models;

namespace InvoiceAPI.IService
{
    public interface IInvoice_DetailService
    {
        Task<Invoice_Detail> CMD_Invoice_Detail(Invoice_Detail oInvoice_Detail);
        Task<Invoice_Detail> GetByInvoiceNo(string nInvoiceNo_Detail);
    }
}
