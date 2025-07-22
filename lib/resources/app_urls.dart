class AppUrls {
  static var baseUrl =
      'https://backend-muskanjehanzeb03-9924-maryam-muskans-projects.vercel.app';

  //signup login verify otp

  static var signUpUrl = '$baseUrl/auth/signup';

  static var signUpPetOwnerUrl = '$baseUrl/auth/signup/pet-owner';

  static var signUpNonPetOwnerUrl = '$baseUrl/auth/signup/non-pet-owner';

  static var signUpVetUrl = '$baseUrl/auth/signup/vet';

  static var signUpAdminUrl = '$baseUrl/auth/signup/admin';

  static var signUpSellerUrl = '$baseUrl/auth/signup/seller';

  static var loginUrl = '$baseUrl/auth/login';

  static var verifyOtp = '$baseUrl/auth/verify-otp';

  static var homeApi = '$baseUrl/Home';

  // pets

  static var pets = '$baseUrl/auth/pets';

  static var getPets = '$baseUrl/auth/pets';

  static var updatePets = '$baseUrl/auth/pets';

  static var deletePets = '$baseUrl/auth/pets';

  // mart

  static var addproduct = '$baseUrl/mart/seller/add-product';

  static var viewOwnProducts = '$baseUrl/mart/seller/products';

  static var viewProductById = '$baseUrl/mart/seller/product';

  static var updateProductById = '$baseUrl/mart/seller/product';

  static var deleteProductById = '$baseUrl/mart/seller/product';

  static var sellerProfile = '$baseUrl/mart/seller/profile';

  static var viewOrdersSeller = '$baseUrl/mart/seller/orders';

  static var updateOrderStatus = '$baseUrl/mart/seller/order';

  static var updateSellerInfo = '$baseUrl/mart/seller/edit-profile';

  static var viewAllProducts = '$baseUrl/mart/buyer/products';

  static var buyProduct = '$baseUrl/mart/buyer/buy';

  static var viewOrdersBuyer = '$baseUrl/mart/buyer/orders';

  static var searchProducts = '$baseUrl/mart/buyer/search';

  static var viewSellerProfileBuyer = '$baseUrl/mart/buyer/seller';

  static var rateSeller = '$baseUrl/mart/rate-seller';

  static var updateOrderStatusBuyer = '$baseUrl/mart/buyer/update-order-status';

  //posts

  static var createPosts = '$baseUrl/post/posts';

  static var getFeed = '$baseUrl/post/posts/feed';

  static var updatePost = '$baseUrl/post/posts';

  static var deletePost = '$baseUrl/post/posts';

  static var likePost = '$baseUrl/post/posts';

  static var commentPost = '$baseUrl/post/posts';

  static var sharePost = '$baseUrl/post/posts';

  static var createStory = '$baseUrl/post/stories';

  static var getUserStory = '$baseUrl/post/stories/user';

  static var deleteStory = '$baseUrl/post/stories';

  static var createVetPost = '$baseUrl/post/vet/posts';

  static var supportVetPost = '$baseUrl/post/vet/posts';

  static var getVetLibrary = '$baseUrl/post/vet/library';

  // profiles

  static var vetprofile = '$baseUrl/profile/vet/profile';
  static var editVetprofile = '$baseUrl/profile/vet/profile/edit';

  static var getUserProfile = '$baseUrl/profile/profile';
  static var editUserProfile = '$baseUrl/profile/profile/edit';
}
