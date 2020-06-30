<!--
 * @Author: your name
 * @Date: 2020-06-29 17:14:38
 * @LastEditTime: 2020-06-30 16:02:54
 * @LastEditors: Please set LastEditors
 * @Description: In User Settings Edit
 * @FilePath: \pikapika-video-website\pikapika\src\components\findPsw\step\Verify.vue
--> 
<template>
  <div class="verifiy-box">
      <el-input v-model="account" placeholder="请输入内容" class="item"></el-input>
      <el-button type="primary" class="item" @click="verifyFn">确认</el-button>
  </div>
</template>

<script>
export default {
  name: 'Verify',
  data() {
    return {
        account:''
    };
  },
  computed:{
  },
  watch:{
  },
  methods: {
    verifyFn() {
      this.$router.push({name:"reset"});
      document.getElementsByClassName("reset")[0].classList.add("active");
      document.getElementsByClassName("verify")[0].classList.remove("active");
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
    .verifiy-box{
        margin: 0 auto;
        // margin-top: 65px;
        width: 70%;
        .item{
            width: 100%;
            margin: 15px 0;
        }
    }
</style>
