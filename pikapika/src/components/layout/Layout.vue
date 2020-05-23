<template>
  <div id="layout">
    <div class="page-header" v-if="path!='/userinfo'">
      <Banner />
      <Navbar />
    </div>
    <keep-alive>
      <router-view/>
    </keep-alive>
    <div class="page-footer">
      <Footer/>
    </div>
  </div>
</template>

<script>
import Banner from "@/components/banner/Banner";
import Navbar from "@/components/navbar/Navbar";
import Footer from "@/components/footer/Footer";

export default {
  name: 'Layout',
  computed:{
    path(){
      return this.$route.path;
    }
  }
}
</script>

<style lang="less">
  div#layout{
      position: relative;
      width: 100%;
        // .page-content{
        //     margin: 0 auto;
        //     width: 1160px;
        //     min-height: 260px;
        //     margin-top: 20px;
        // }
    }
</style>
