using Microsoft.EntityFrameworkCore;
using System.ComponentModel.DataAnnotations;

namespace ProjectProductData.Models
{
    public class AddProduct
    {
        [Key]
        public string ProductID { get; set; }

        [Required(ErrorMessage ="Please Enter Product Name")]
        public string ProductName { get; set; } = string.Empty;
        [Required]
        public decimal ProductSize { get; set; }
        [Required]
        public decimal ProductPrize { get; set; }
    }

   public class GetUnqPID
    {
        
        public string ProductID { get; set; }
    }
  
}
