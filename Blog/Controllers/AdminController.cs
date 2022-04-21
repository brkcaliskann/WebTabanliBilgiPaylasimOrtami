using Blog.App_Classes;
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
    public class AdminController : Controller
    {
        BlogDB context = new BlogDB();

        [Authorize(Roles = "Admin")]
        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }

        [Authorize(Roles = "Admin")]
        public ActionResult MakaleEkle()
        {
            var data = context.Makale.Select(x => x.KategoriID).ToList();
            ViewBag.KategoriID = new SelectList(context.Kategori, "KategoriID", "Adi", selectedValue: data);
            ViewBag.EtiketID = new SelectList(context.Etiket, "EtiketID", "Adi", selectedValue: data);

            return View();
        }

        [HttpPost]
        public ActionResult MakaleEkle(Makale mkl, HttpPostedFileBase resim)
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
                mkl.AktifMi = true;
                mkl.OnaylandiMi = true;
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

        [Authorize(Roles = "Admin")]
        public ActionResult EtiketListele()
        {
            var etiket = context.Etiket.ToList();
            return View(etiket);
        }
        [Authorize(Roles = "Admin")]
        public ActionResult EtiketEkle()
        {
            return View();
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult EtiketEkle(Etiket etk)
        {
            etk.AktifMİ = true;
            context.Etiket.Add(etk);
            context.SaveChanges();
            return RedirectToAction("EtiketListele");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult EtiketDuzenle(int id)
        {
            return View(context.Etiket.FirstOrDefault(x => x.EtiketID == id));
        }
        
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult EtiketDuzenle(Etiket etk)
        {
            context.Entry(etk).State = System.Data.Entity.EntityState.Modified;
            context.SaveChanges();
            return RedirectToAction("EtiketListele");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult EtiketSil(int id)
        {
            var etksil = context.Etiket.Where(x => x.EtiketID == id).FirstOrDefault();
            return View(etksil);
        }
        
        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult EtiketSil(int id, Etiket etk)
        {
            var etksil = context.Etiket.Where(x => x.EtiketID == id).FirstOrDefault();
            context.Entry(etksil).State = System.Data.Entity.EntityState.Deleted;
            context.SaveChanges();
            return RedirectToAction("EtiketListele");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult TumMakaleler(Makale mkl)
        {
            var data = context.Makale.OrderByDescending(x => x.MakaleID).ToList();
            return View(data);

        }

        [Authorize(Roles = "Admin")]
        public ActionResult TumYorumlar(Yorum yrm)
        {
            var data = context.Yorum.OrderByDescending(x => x.YorumID).ToList();
            return View(data);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult YorumSil(int id)
        {
            var yorum = context.Yorum.Where(m => m.YorumID == id).FirstOrDefault();
            return View(yorum);
        }


        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult YorumSil(int id , Yorum yorum)
        {
            var yrmsil = context.Yorum.Where(x => x.YorumID == id).FirstOrDefault();
            context.Entry(yrmsil).State = System.Data.Entity.EntityState.Deleted;
           
            context.SaveChanges();
            return RedirectToAction("TumYorumlar");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult YorumDetayGoster(int id)
        {
            Yorum mkl = context.Yorum.Where(x => x.YorumID == id).FirstOrDefault();

            return View(mkl);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult MakaleDuzenle(int id)
        {
            var data = context.Makale.Where(x => x.MakaleID == id).FirstOrDefault();
            ViewBag.KategoriID = new SelectList(context.Kategori, "KategoriID", "Adi", selectedValue: data.KategoriID);
            ViewBag.EtiketID = new SelectList(context.Etiket, "EtiketID", "Adi", selectedValue: data.EtiketID);
            return View(data);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult MakaleDuzenle(Makale mkl,int id)
        {
            mkl.OnaylandiMi = true;
            mkl.AktifMi = true;
            context.Entry(mkl).State = System.Data.Entity.EntityState.Modified;
            context.SaveChanges();
            return RedirectToAction("TumMakaleler");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult MakaleSil(int id)
        {
            var makale = context.Makale.Where(m => m.MakaleID == id).SingleOrDefault();
            return View(makale);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult MakaleSil(int id, FormCollection collection)
        {
            try
            {
                var makales = context.Makale.Where(m => m.MakaleID == id).FirstOrDefault();
                if (makales == null)
                {
                    return HttpNotFound();
                }
                if (System.IO.File.Exists(Server.MapPath(makales.Resim.KucukBoyutResim)))
                {
                    System.IO.File.Delete(Server.MapPath(makales.Resim.KucukBoyutResim));

                }
                if (System.IO.File.Exists(Server.MapPath(makales.Resim.OrtaBoyutResim)))
                {
                    System.IO.File.Delete(Server.MapPath(makales.Resim.OrtaBoyutResim));

                }
                if (System.IO.File.Exists(Server.MapPath(makales.Resim.BuyukBoyutResim)))
                {
                    System.IO.File.Delete(Server.MapPath(makales.Resim.BuyukBoyutResim));
                }

                foreach (var i in makales.Yorum.ToList())
                {
                    context.Yorum.Remove(i);
                }

                context.MakaleEtiket.Remove(context.MakaleEtiket.FirstOrDefault(x => x.MakaleID == id));
                context.SaveChanges();

                context.Resim.Remove(makales.Resim);
                context.Entry(makales).State = System.Data.Entity.EntityState.Deleted;
                context.SaveChanges();

                return RedirectToAction("TumMakaleler");

            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                return View();
            }
        }

        [Authorize(Roles = "Admin")]
        public ActionResult YazarOnaylari()
        {
            var data = context.Kullanici.Where(x => x.YazarMi == false && x.OnaylandiMi == false).ToList();
            return View(data);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult OnayVer(int id)
        {
            Kullanici kl = context.Kullanici.FirstOrDefault(x => x.KullaniciID == id);
            kl.OnaylandiMi = true;
            kl.YazarMi = true;
            kl.BeniHatirla = false;
            context.SaveChanges();

            Rol yazar = context.Rol.FirstOrDefault(x => x.RolAdi == "Yazar");
            KullaniciRol kr = new KullaniciRol();
            kr.RolID = yazar.RolID;
            kr.KullaniciID = kl.KullaniciID;

            context.KullaniciRol.Add(kr);
            context.SaveChanges();
            return RedirectToAction("YazarOnaylari");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult OnayVerme(int id)
        {
            Kullanici kl = context.Kullanici.FirstOrDefault(x => x.KullaniciID == id);
            kl.OnaylandiMi = true;
            kl.YazarMi = false;
            context.SaveChanges();

            return RedirectToAction("YazarOnaylari");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult MakaleOnaylari()
        {
            var data = context.Makale.Where(x => x.AktifMi == false && x.OnaylandiMi == false).ToList();
            return View(data);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult MakaleOnayVer(int id)
        {
            Makale mkl = context.Makale.Where(x => x.MakaleID == id).FirstOrDefault();
            mkl.AktifMi = true;
            mkl.OnaylandiMi = true;
            context.SaveChanges();

            return RedirectToAction("MakaleOnaylari");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult MakaleOnayVerme(int id)
        {
            Makale mkl = context.Makale.FirstOrDefault(x => x.MakaleID == id);
            mkl.AktifMi = false;
            mkl.OnaylandiMi = true;
            context.MakaleEtiket.Remove(context.MakaleEtiket.FirstOrDefault(x => x.MakaleID == id));
            context.SaveChanges();

            context.Entry(mkl).State = System.Data.Entity.EntityState.Deleted;
            context.SaveChanges();

            return RedirectToAction("MakaleOnaylari");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult MakaleDetayGoster(int id)
        {
            Makale mkl = context.Makale.Where(x => x.MakaleID == id).FirstOrDefault();
            return View(mkl);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult MakaleDetayDuzelt(int id)
        {
            var data = context.Makale.Where(x => x.MakaleID == id).FirstOrDefault();
            ViewBag.KategoriID = new SelectList(context.Kategori, "KategoriID", "Adi", selectedValue: data.KategoriID);
            ViewBag.EtiketID = new SelectList(context.Etiket, "EtiketID", "Adi", selectedValue: data.EtiketID);

            return View(data);
        }

        [HttpPost]
        [Authorize(Roles = "Admin")]
        public ActionResult MakaleDetayDuzelt(Makale mkl)
        {
            context.Entry(mkl).State = System.Data.Entity.EntityState.Modified;
            mkl.AktifMi = false;
            mkl.OnaylandiMi = false;
            context.SaveChanges();
            return RedirectToAction("MakaleOnaylari");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult YorumOnaylari()
        {
            var data = context.Yorum.Where(x => x.AktifMi == false && x.OnaylandiMi == false).ToList();
            return View(data);
        }

        [Authorize(Roles = "Admin")]
        public ActionResult YorumOnayVer(int id)
        {
            Yorum yrm = context.Yorum.FirstOrDefault(x => x.YorumID == id);
            yrm.AktifMi = true;
            yrm.OnaylandiMi = true;
            context.SaveChanges();

            return RedirectToAction("YorumOnaylari");
        }

        [Authorize(Roles = "Admin")]
        public ActionResult YorumOnayVerme(int id)
        {
            Yorum yrm = context.Yorum.FirstOrDefault(x => x.YorumID == id);
            yrm.AktifMi = false;
            yrm.OnaylandiMi = true;

            context.Entry(yrm).State = System.Data.Entity.EntityState.Deleted;
            context.SaveChanges();
            return RedirectToAction("YorumOnaylari");
        }

    }
}