using Blog.Attributes;
using Blog.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Blog.Controllers
{
    public class MakaleController : Controller
    {
        BlogDB context = new BlogDB();
        // GET: Makale
        [AllowAnonymous]
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        [AllowAnonymous]
        public ActionResult Detay(int id)
        {
            Makale mkl = context.Makale.Where(x => x.MakaleID == id).FirstOrDefault();
            mkl.GoruntulenmeSayisi++;

            context.SaveChanges();
            return View(mkl);
        }

        [HttpPost]
        [AllowAnonymous]
        [LogKayıtAttributes]
        public ActionResult YorumYaz(int id, string Icerik)
        {
            int klid = Convert.ToInt32(Session["uyeid"]);
            
            Yorum yorum = new Yorum();
            yorum.KullaniciID = klid; 
            yorum.Icerik = Icerik;
            yorum.MakaleID = id;
            yorum.EklenmeTarihi = DateTime.Now;
            yorum.OnaylandiMi = false;
            yorum.AktifMi = false;

            context.Yorum.Add(yorum);
            context.SaveChanges();

            return RedirectToAction("Detay", new { id = yorum.MakaleID });
        }

        [LogKayıtAttributes]
        public ActionResult YorumSil(int id)
        {
            var uyeid = Session["uyeid"];
            
            var yorum = context.Yorum.Where(y => y.YorumID == id).SingleOrDefault();
            var makale = context.Makale.Where(m => m.MakaleID == yorum.MakaleID).SingleOrDefault();
            if (uyeid != null)
            {
                context.Yorum.Remove(yorum);
                context.SaveChanges();
                return RedirectToAction("Detay", "Makale", new { id = makale.MakaleID });
            }
            else
            {
                return HttpNotFound();
            }
        }

        [AllowAnonymous]
        public string Begen(int id)
        {
            Makale mkl = context.Makale.FirstOrDefault(x => x.MakaleID == id);
            mkl.BegeniSayisi++;
            context.SaveChanges();
            return mkl.BegeniSayisi.ToString();
        }
    }
}