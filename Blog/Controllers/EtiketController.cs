using Blog.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Blog.Controllers
{
    public class EtiketController : Controller
    {
        BlogDB context = new BlogDB();
        // GET: Etiket
        
        public ActionResult Index(int id, int? SayfaNo)
        {
            int _sayfaNo = SayfaNo ?? 1;
            var data = context.Makale.Where(x => x.Etiket.EtiketID == id && x.AktifMi == true);
            return View("Index", data.OrderByDescending(m => m.EklenmeTarihi).ToPagedList(_sayfaNo, 4));
           
        }
 
        public PartialViewResult EtiketlerWidget()
        {
            var data = context.Etiket.ToList();
            return PartialView(data);
        }

        
    }
}