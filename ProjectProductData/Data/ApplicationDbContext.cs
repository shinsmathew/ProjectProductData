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
            modelBuilder.Entity<GetUnqPID>().HasNoKey();
            
        }
        public DbSet<ProductList> productlists { get; set; }
        public DbSet<GetUnqPID> gpids { get; set; }

        public async Task<List<GetUnqPID>> GetStoredProcedureResultsAsync()
        {
            return await gpids.FromSqlRaw("EXECUTE GetProductID").ToListAsync();
        }
    }
}
