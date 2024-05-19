using Microsoft.EntityFrameworkCore;
using ProjectProductData.Models;

namespace ProjectProductData.Data
{
    public class ApplicationDbContext:DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options): base(options) 
        { 
        }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<GPID>().HasNoKey();
            
        }
        public DbSet<ProductList> productlists { get; set; }
        public DbSet<GPID> gpids { get; set; }

        public async Task<List<GPID>> GetStoredProcedureResultsAsync()
        {
            return await gpids.FromSqlRaw("EXECUTE GetProductID").ToListAsync();
        }
    }
}
