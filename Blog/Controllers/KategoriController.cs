using Blog.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Blog.Controllers
{
    public class KategoriController : Controller
    {
        BlogDB context = new BlogDB();
        // GET: Kategori
        public ActionResult Index(int id, int? SayfaNo)
        {
            int _sayfaNo = SayfaNo ?? 1;
            var mkl = context.Makale.Where(m => m.KategoriID == id && m.AktifMi == true).ToList();
            return View("Index", mkl.OrderByDescending(m => m.EklenmeTarihi).ToPagedList(_sayfaNo, 4));
        }

        public ActionResult Kategori(int id)
        {
            return View(context.Kategori.Where(x => x.KategoriID == id).ToList());
        }

        public PartialViewResult KategoriWidget()
        {
            
            var data = context.Kategori.Include(m => m.Makale).ToList();
            return PartialView(data);
        }

      
        [Authorize(Roles = "Admin")]
        
        public ActionResult KategoriListele()
        {
            var data = context.Kategori.ToList();
            return View(data);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult KategoriEkle()
        {
            return View();
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult KategoriEkle(Kategori kat)
        {
            context.Kategori.Add(kat);
            context.SaveChanges();
            return RedirectToAction("KategoriListele");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult KategoriDuzenle(int id)
        {

            return View(context.Kategori.FirstOrDefault(x => x.KategoriID == id));
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult KategoriDuzenle(Kategori kat)
        {

            context.Entry(kat).State = System.Data.Entity.EntityState.Modified;
            context.SaveChanges();
            return RedirectToAction("KategoriListele");
        }

        public ActionResult KategoriSil(int id)
        {
            var data = context.Makale.Where(x => x.KategoriID == id).FirstOrDefault();

            if (data != null)
            {
                TempData["Mesaj"] = "Kategoriye bağlı makaleler mevcut. Kategoriyi silmeden once ona bağlı makaleleri silmelisiniz!!";
                return RedirectToAction("KategoriListele");
            }

            else
            {
                context.Kategori.Remove(context.Kategori.FirstOrDefault(x => x.KategoriID == id));
                context.SaveChanges();
                return RedirectToAction("KategoriListele");
            }
        }
    }
}