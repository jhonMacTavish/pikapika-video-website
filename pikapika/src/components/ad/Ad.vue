<template>
  <div class="ad-box">
    <a href="https://7segu.taobao.com/?mm_sycmid=1_62746_0baf15f9c58912f036f1caf76317ec4a">
      <img src="https://cdn.u1.huluxia.com/g3/M01/53/F2/wKgBOV6haP2AXER-AAFhyKHjFJk277.jpg" alt />
    </a>
  </div>
</template>

<script>
export default {
  name: "Ad",
  data() {
    return {
      browserWidth: 0
    };
  }
};
</script>

<style lang="less" scoped>
  .ad-box{
    margin-top: 20px;
    width: 100%;
    a{
      width: 100%;
      img{
        width: 100%;
        overflow: auto;
      }
    }
  }
</style>