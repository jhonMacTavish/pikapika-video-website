<template>
  <div class="register-page">
    <div class="banner"></div>
    <router-view></router-view>
    <Footer />
  </div>
</template>

<script>
export default {
  name: "RegisterPage",
  data() {
    return {};
  },
  computed: {},
  watch: {},
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
.register-page {
  width: 100%;
  .banner {
    width: 100%;
    height: 282px;
    background: url(http://tva2.sinaimg.cn/large/006AYjs4ly1g7axntaeu7j31uo0cetk3.jpg);
    background-position: center;
    background-size: cover;
    overflow: hidden;
  }
}
</style>
