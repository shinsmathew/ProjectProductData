using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;
using ProjectProductData.Data;
using ProjectProductData.Models;

namespace ProjectProductData.Controllers
{
    public class ProductController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ProductController(ApplicationDbContext context)
        {
            _context = context;
        }
        public IActionResult AddProduct()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> AddProduct(AddProduct AdPr)
        {
            if(ModelState.IsValid)
            {
                string shortName = AdPr.ProductName.Substring(0, Math.Min(4, AdPr.ProductName.Length));
                if (shortName.Length < 4)
                {
                    int remaining = 4 - shortName.Length;
                    shortName += new string('X', remaining);
                }
                // Finding the Count From DB

                //var counter = await _context.productlists.FromSqlRaw("EXECUTE GetProductID").ToListAsync();
                var counter = await _context.Database.ExecuteSqlRawAsync("GetProductID");



                string uniqueCode = $"{shortName}{counter:D3}";

                AdPr.ProductID = uniqueCode;

             
                bool PID = await _context.productlists.AnyAsync(x => x.ProductName==AdPr.ProductName);

                if (PID)
                {
                    TempData["EMsg"] = "Product Already Added";
                    return RedirectToAction("AddProduct");

                }
                else
                {
                    var pdct = new ProductList
                    {
                        ProductID = AdPr.ProductID,
                        ProductName = AdPr.ProductName,
                        ProductPrize = AdPr.ProductPrize,
                        ProductSize = AdPr.ProductSize,
                    };
                    await _context.productlists.AddAsync(pdct);
                    await _context.SaveChangesAsync();

                    TempData["SMsg"] = "Product Added Successfully!";
                    return RedirectToAction("AddProduct");
                }
                
            }
            return View();
        }



        public async Task<IActionResult> ProductList()
        {
            List<ProductList> results = new List<ProductList>();

            results = await _context.productlists.ToListAsync();

            return View(results);


        }

        [HttpGet]
        public async Task<IActionResult> Edit(string id)
        {

            var pdt = await _context.productlists.FindAsync(id);
            return View(pdt);

        }

        [HttpPost]
        public async Task<IActionResult> Edit(ProductList pdt)
        {
            if (ModelState.IsValid)
            {


                var Eprdt = await _context.productlists.FindAsync(pdt.ProductID);
                if (Eprdt is not null)
                {
                    Eprdt.ProductName = pdt.ProductName;
                    Eprdt.ProductPrize = pdt.ProductPrize;
                    Eprdt.ProductSize = pdt.ProductSize;
                   
                    await _context.SaveChangesAsync();

                }
                return RedirectToAction("ProductList");




            }
            else
            {
                TempData["EMsg"] = "Something Went Wrong Please check the values";
                return RedirectToAction("Edit");
            }



        }


        [HttpPost]
        public async Task<IActionResult> Delete(string id)
        {
            var cust = await _context.productlists
                .AsNoTracking()
                .FirstOrDefaultAsync(x => x.ProductID == id);
            if (cust is not null)
            {
                _context.productlists.Remove(cust);
                await _context.SaveChangesAsync();
            }

            return RedirectToAction("ProductList");
        }


    }
}
