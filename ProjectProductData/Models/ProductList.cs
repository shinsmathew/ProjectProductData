using System.ComponentModel.DataAnnotations;

namespace ProjectProductData.Models
{
    public class ProductList
    {
        [Key]
        public string ProductID { get; set; }
        [Required]
        public string ProductName { get; set; } = string.Empty;
        [Required]
        public decimal ProductSize { get; set; }
        [Required]
        public decimal ProductPrize { get; set; }

    }
}
