using Blog.App_Classes;
using Blog.Attributes;
using Blog.Models;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Blog.Controllers
{
    [LogKayıtAttributes]
    public class YazarController : Controller
    {
        BlogDB context = new BlogDB();
        // GET: Yazar
        public ActionResult Index()
        {
            return View();
        }
       
        public ActionResult YazarOl()
        {
            string userName = User.Identity.Name;
            int klid = context.Kullanici.Where(x => x.KullaniciAdi == userName).Select(x => x.KullaniciID).FirstOrDefault();  

            var data = context.Kullanici.Where(x => x.KullaniciID == klid).FirstOrDefault();

            return View(data);
        }

        [HttpPost]
        [LogKayıtAttributes]
        public ActionResult YazarOl(Kullanici kl, HttpPostedFileBase resim)
        {
            if (kl != null)
                {
                    string userName = User.Identity.Name;
                    int klid = context.Kullanici.Where(x => x.KullaniciAdi == userName).Select(x => x.KullaniciID).FirstOrDefault();  //isimden kullanıcı id sini alma

                    Image img = Image.FromStream(resim.InputStream);
                    Bitmap kckResim = new Bitmap(img, Settings.ResimKucukBoyut);

                    kckResim.Save(Server.MapPath("/Content/MakaleResim/KucukBoyut/" + resim.FileName));

                    Resim rsm = new Resim();
                    rsm.KucukBoyutResim = "/Content/MakaleResim/KucukBoyut/" + resim.FileName;


                    context.Resim.Add(rsm);
                    context.SaveChanges();
                    kl.KullaniciID = klid;
                    kl.YazarMi = false;
                    kl.OnaylandiMi = false;
                    kl.AktifMi = true;
                    kl.KayitTarihi = DateTime.Now;
                    kl.ResimID = rsm.ResimID;
                    context.Entry(kl).State = System.Data.Entity.EntityState.Modified;
                    context.SaveChanges();
                }
                else
                {
                    return View("UyeOl", "Kullanici");
                }

            return RedirectToAction("Index", "Home");
        }

        [Authorize(Roles = "Admin, Yazar")]
        public ActionResult YazarMakaleEkle()
        {
            var data = context.Makale.Select(x => x.KategoriID).ToList();
            ViewBag.KategoriID = new SelectList(context.Kategori, "KategoriID", "Adi", selectedValue: data);
            ViewBag.EtiketID = new SelectList(context.Etiket, "EtiketID", "Adi", selectedValue: data);
            return View();
        }

        [HttpPost]
        [Authorize(Roles = "Admin, Yazar")]
        [LogKayıtAttributes]
        public ActionResult YazarMakaleEkle(Makale mkl, HttpPostedFileBase resim, string etiketler)
        {
            try
            {

                string newname = Path.GetFileNameWithoutExtension(resim.FileName) + "-" + Guid.NewGuid() + Path.GetExtension(resim.FileName);

                Image img = Image.FromStream(resim.InputStream);
                Bitmap kckResim = new Bitmap(img, Settings.ResimKucukBoyut);
                Bitmap orResim = new Bitmap(img, Settings.ResimOrtaBoyut);
                Bitmap byResim = new Bitmap(img, Settings.ResimBuyukBoyut);

                kckResim.Save(Server.MapPath("~/Content/MakaleResim/KucukBoyut/" + newname));
                orResim.Save(Server.MapPath("~/Content/MakaleResim/OrtaBoyut/" + newname));
                byResim.Save(Server.MapPath("~/Content/MakaleResim/BuyukBoyut/" + newname));

                Resim rsm = new Resim();

                rsm.BuyukBoyutResim = "/Content/MakaleResim/BuyukBoyut/" + newname;
                rsm.OrtaBoyutResim = "/Content/MakaleResim/OrtaBoyut/" + newname;
                rsm.KucukBoyutResim = "/Content/MakaleResim/KucukBoyut/" + newname;

                context.Resim.Add(rsm);
                mkl.ResimID = rsm.ResimID;
                mkl.EklenmeTarihi = DateTime.Now;
                mkl.GoruntulenmeSayisi = 0;
                mkl.BegeniSayisi = 0;
                mkl.AktifMi = false;
                mkl.OnaylandiMi = false;
                int yzrId = context.Kullanici.FirstOrDefault(x => x.KullaniciAdi == User.Identity.Name).KullaniciID;
                mkl.KullaniciID = yzrId;

                context.Makale.Add(mkl);
                context.SaveChanges();

                MakaleEtiket kr = new MakaleEtiket();

                kr.MakaleID = mkl.MakaleID;
                kr.EtiketID = (int)mkl.EtiketID;

                context.MakaleEtiket.Add(kr);
                context.SaveChanges();
            }


            catch (System.Data.Entity.Validation.DbEntityValidationException dbEx)
            {
                Exception raise = dbEx;
                foreach (var validationErrors in dbEx.EntityValidationErrors)
                {
                    foreach (var validationError in validationErrors.ValidationErrors)
                    {
                        string message = string.Format("{0}:{1}",
                            validationErrors.Entry.Entity.ToString(),
                            validationError.ErrorMessage);
                        // raise a new exception nesting
                        // the current instance as InnerException
                        raise = new InvalidOperationException(message, raise);
                    }
                }
                throw raise;
            }

            return RedirectToAction("Index", "Home");
        }

        [Authorize(Roles = "Admin, Yazar")]
        [LogKayıtAttributes]
        public ActionResult Makalelerim()
        {
            string userName = User.Identity.Name;
            int klid = context.Kullanici.Where(x => x.KullaniciAdi == userName).Select(x => x.KullaniciID).FirstOrDefault();  //isimden kullanıcı id sini alma
            var listele = context.Makale.Where(x => x.KullaniciID == klid).ToList();
            return View(listele);
        }
        [Authorize(Roles = "Admin, Yazar")]
        public ActionResult Duzenle(int id)
        {
            var data = context.Makale.Where(x => x.MakaleID == id).FirstOrDefault();

            ViewBag.KategoriID = new SelectList(context.Kategori, "KategoriID", "Adi", selectedValue: data.KategoriID);
            ViewBag.EtiketID = new SelectList(context.Etiket, "EtiketID", "Adi", selectedValue: data.EtiketID);
            return View(data);
        }

        [HttpPost]
        [Authorize(Roles = "Admin, Yazar")]
        [LogKayıtAttributes]
        public ActionResult Duzenle(Makale mkl)
        {
            mkl.OnaylandiMi = true;
            mkl.AktifMi = true;
            context.Entry(mkl).State = System.Data.Entity.EntityState.Modified;
            context.SaveChanges();
            return RedirectToAction("Makalelerim");

        }
    }
}
