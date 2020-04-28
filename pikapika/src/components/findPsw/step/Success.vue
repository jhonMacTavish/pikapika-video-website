<template>
  <div class="success-box">
    <div class="message">
      密码重置成功！
    </div>
    <div class="image"></div>
    <div class="button-wrap">
      <el-button type="primary" class="button" @click="$router.push({name:'login'})">前往登录页</el-button>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Success',
  data() {
    return {
    };
  },
  computed:{
  },
  watch:{
  },
  methods: {},
  components: {}
};
</script>

<style lang='less' scoped>
  .success-box{
    width: 100%;
    // height: 20px;
    // background: turquoise;
    // margin-top: ;
    .message{
      margin: 0 auto;
      margin-bottom: 20px;
      text-align: center;
      font-size: 32px;
    }
    
    .image{
      // display: inline-block;
      margin: 0 auto;
      margin-bottom: 20px;
      width: 200px;
      height: 200px;
      background: url(https://s1.hdslb.com/bfs/static/passport/static/img/result-success.5934aaa.png);
      background-repeat: no-repeat;
      background-position: center;
      background-size: contain;
    }

    .button-wrap{
      width: 200px;
      margin: 0 auto;
      margin-bottom: 30px;
      .button{
        width: 100%;

      }
    }
  }
</style>
