using Blog.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Blog.Attributes
{
    public class LogKayıtAttributes : ActionFilterAttribute, IActionFilter
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
           
            BlogDB context = new BlogDB();
            Log yenilog = new Log();
            
                yenilog.MetotAdi = filterContext.ActionDescriptor.ActionName + " isimli metot çağrıldı";
                yenilog.IP = filterContext.HttpContext.Request.UserHostAddress;
                yenilog.Tarayici = filterContext.HttpContext.Request.UserAgent;
                yenilog.Tarih = DateTime.Now;
                yenilog.ControllerAdi = filterContext.ActionDescriptor.ControllerDescriptor.ControllerName;
                yenilog.KullaniciAdi = filterContext.HttpContext.User.Identity.Name;
                
            context.Log.Add(yenilog);
            context.SaveChanges();
        }
    }
}