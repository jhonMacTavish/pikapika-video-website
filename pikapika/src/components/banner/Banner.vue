<template>
  <div class="banner-box">
  </div>
</template>

<script>
export default {
  name: "Banner",
  data() {
    return {
      browserWidth: 0
    };
  },
  created() {}
};
</script>

<style lang="less" scoped>
.banner-box {
  margin: 0 auto;
  position: relative;
  z-index: 0;
  min-height: 155px;
  min-width: 999px;
  background-color: #f9f9f9;
  display: -ms-flexbox;
  display: flex;
  -ms-flex-pack: center;
  justify-content: center;
  background-repeat: no-repeat;
  background-position: center 0;
  background-size: cover;
  background-image: url(../../../static/imgs/banner/banner.png);

}
</style>