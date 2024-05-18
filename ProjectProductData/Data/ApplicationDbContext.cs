using Microsoft.EntityFrameworkCore;
using ProjectProductData.Models;

namespace ProjectProductData.Data
{
    public class ApplicationDbContext:DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options): base(options) 
        { 
        }

        public DbSet<ProductList> productlists { get; set; }
       
        
    }
}
