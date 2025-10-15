<template>
  <footer id="footer" class="footer dark-background">
    <div class="footer-top">
      <div class="container">
        <div class="row gy-4 py-3">
          <div class="col-sm-12 col-lg-6 footer-about">
            <a href="index.html" class="logo d-flex align-items-center">
              <img src="/src/assets/image/kitchencraft-logo.png"/>
            </a>
            <div class="footer-contact pt-3">
              <p>Company: Kitchencraft</p>
              <p>Address: Inayagan City of Cebu, Philippines</p>
              <p>Phone: 0994 226 1186</p>
              <p>Email: kitchencraft@gmail.com</p>
            </div>
          </div>
          <div class="col-sm-12 col-lg-6 footer-links">
            <h4 class="text-danger">Quick Links</h4>
            <ul>
              <li><a href="#">Home</a></li>
              <li><a href="#">About us</a></li>
              <li><a href="#">Terms of service</a></li>
              <li><a href="#">Privacy policy</a></li>
            </ul>
          </div>
        </div>
      </div>
    </div>

    <div class="copyright text-center">
      <div class="container d-flex flex-column flex-lg-row justify-content-center justify-content-lg-between align-items-center">

        <div class="d-flex flex-column align-items-center align-items-lg-start">
          <div>
            © Copyright <strong><span>www.kitchencraft.com</span></strong>. All Rights Reserved
          </div>
        </div>

        <div class="social-links order-first order-lg-last mb-3 mb-lg-0">
          <a href=""><i class="bi bi-twitter-x text-danger"></i></a>
          <a href=""><i class="bi bi-facebook text-danger"></i></a>
          <a href=""><i class="bi bi-instagram text-danger"></i></a>
          <a href=""><i class="bi bi-linkedin text-danger"></i></a>
        </div>

      </div>
    </div>

  </footer>
</template>
<script lang="ts">

  import { defineComponent } from 'vue';

  export default defineComponent({
    name: "SectionFooter"
  });

</script>