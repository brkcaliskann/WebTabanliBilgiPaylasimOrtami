using Blog.Attributes;
using Blog.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Blog.Controllers
{
     public class HomeController : Controller
    {
        BlogDB context = new BlogDB();
        public ActionResult Index(int? SayfaNo)
        {
            int _sayfaNo = SayfaNo ?? 1;
            var mkl = context.Makale.Where(m => m.AktifMi == true).OrderByDescending(m => m.MakaleID).ToPagedList(_sayfaNo, 4);

            return View("Index", mkl);
        }

        public PartialViewResult PopulerMakalelerWidget()
        {
            var model = context.Makale.Where(x => x.AktifMi == true).OrderByDescending(x => x.GoruntulenmeSayisi).Take(3).ToList();
            return PartialView(model);
        }
        public ActionResult Iletisim()
        {
            return View();
        }

        public ActionResult BolumumuzHakkinda()
        {
            return View();
        }

        public ActionResult MakaleAra(string ara)
        {
            var data = context.Makale.Where(x => x.Icerik.Contains(ara) || x.Baslik.Contains(ara) || ara == null).ToList();
            return PartialView(data);
        }
    }
}