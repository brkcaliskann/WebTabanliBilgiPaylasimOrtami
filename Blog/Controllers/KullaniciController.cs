using Blog.App_Classes;
using Blog.Attributes;
using Blog.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace Blog.Controllers
{
    public class KullaniciController : Controller
    {
        BlogDB context = new BlogDB();

        // GET: Kullanici
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult GirisYap()
        {
            return View();
        }

        [HttpPost]
        public ActionResult GirisYap(Kullanici kl)
        {
            if (!ModelState.IsValid)
            {
                return View("Index", kl);
            }

            var kullaniciVarmi = context.Kullanici.FirstOrDefault(x => x.KullaniciAdi == kl.KullaniciAdi && x.Parola == kl.Parola);

            if (kullaniciVarmi != null)
            {
                Session["uyeid"] = kullaniciVarmi.KullaniciID;

                FormsAuthentication.SetAuthCookie(kullaniciVarmi.KullaniciAdi, kl.BeniHatirla);

                return RedirectToAction("Index", "Home");
            }

            return RedirectToAction("Index", "Home");
        }

        [LogKayıtAttributes]
        [HttpPost]
        public ActionResult CikisYap()
        {
            Session.Abandon();
            Response.Cookies.Clear();

            FormsAuthentication.SignOut();

            return RedirectToAction("Index", "Home");
        }

        public ActionResult UyeOl()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UyeOl(Kullanici kl)
        {
            kl.YazarMi = false;
            kl.OnaylandiMi = false;
            kl.AktifMi = true;
            kl.DogumTarihi = kl.DogumTarihi.Value.Date;
            kl.KayitTarihi = DateTime.Now;

            context.Kullanici.Add(kl);
            context.SaveChanges();

            Rol kullanici = context.Rol.FirstOrDefault(x => x.RolAdi == "Kullanici");
            KullaniciRol kr = new KullaniciRol();
            kr.RolID = kullanici.RolID;
            kr.KullaniciID = kl.KullaniciID;

            context.KullaniciRol.Add(kr);
            context.SaveChanges();
            return RedirectToAction("Index", "Home");

        }

        public ActionResult SifremiUnuttum()
        {
            return View();
        }

        [HttpPost]
        [LogKayıtAttributes]
        public ActionResult SifremiUnuttum(string Mail)
        {
            var data = context.Kullanici.Where(m => m.Mail == Mail).FirstOrDefault();

            if (data != null)
            {
                Random rnd = new Random();
                int kod = rnd.Next();
                System.Web.HttpContext.Current.Session["Kod"] = kod;

                MailMessage mail = new MailMessage();
                mail.IsBodyHtml = true;
                mail.To.Add(data.Mail);
                mail.From = new MailAddress("guest97@outlook.com.tr", "Şifre Güncelleme", System.Text.Encoding.UTF8);
                mail.Subject = "Şifre Güncelleme Talebi";
                mail.Body = $"Şifre Yenileme Doğrulama Kodunuz : " + kod;
                mail.IsBodyHtml = true;

                SmtpClient smp = new SmtpClient();

                smp.EnableSsl = true;
                smp.UseDefaultCredentials = false;
                smp.Credentials = new NetworkCredential("guest97@outlook.com.tr", "burak.3880");
                smp.Port = 587;
                smp.Host = "smtp.office365.com";
                smp.DeliveryMethod = SmtpDeliveryMethod.Network;
                smp.Send(mail);

                return Redirect("/Kullanici/SifremiYenile/" + kod);
            }
            else
            {
                ViewBag.Uyari = "Bir hata oluştu. Tekrar Deneyiniz!";
            }

            return View();
        }

        public ActionResult SifremiYenile(int id)
        {
            var sifreunutan = context.Kullanici.Where(m => m.KullaniciID == id).SingleOrDefault();
            return View(sifreunutan);
        }

        [HttpPost]
        [LogKayıtAttributes]
        public ActionResult SifremiYenile(string Mail, string sifre, int kod)
        {
            var data = context.Kullanici.Where(m => m.Mail == Mail).SingleOrDefault();

            if (kod == (int)Session["Kod"])
            {
                data.Parola = sifre.ToString();
                context.SaveChanges();
                Session.Abandon();
                ViewBag.uyari = "Şifre Değişimi Sağlandı! Giriş Yapabilirsiniz.";
                return Redirect("/Kullanici/GirisYap1");
            }
            else
            {
                ViewBag.Uyari = "Bir hata oluştu. Kodunuzu, Mail Adresinizi kontrol ederek tekrar deneyiniz!";
            }

            return View();
        }
    }
}
