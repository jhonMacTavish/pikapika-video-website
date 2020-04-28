<template>
  <div class="verifiy-box">
      <el-input v-model="account" placeholder="请输入内容" class="item"></el-input>
      <el-button type="primary" class="item" @click="$router.push({name:'reset'})">确认</el-button>
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
  methods: {},
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
