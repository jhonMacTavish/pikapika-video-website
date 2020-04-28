<template>
  <div class="page-content">
    <div class="error-box">
      <div class="error-panel">
        <img src="//static.hdslb.com/error/very_sorry.png" alt />
        <div class="button-wrap">
          <el-button type="primary">返回上一页</el-button>
        </div>
        <div class="error-split">
          <div class="error-tip">
            休息一下，玩玩魔方吧
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "ErrorPage",
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
.page-content {
  // background: #F4F5F7;
  .error-box {
    width: 100%;
    height: 800px;
    border-radius: 10px;
    box-shadow: 0 0 6px 2px rgba(0, 0, 0, 0.1);

    .error-panel {
      width: 100%;
      text-align: center;
      .button-wrap{
        margin-bottom: 40px;
      }

      .error-split{
        widows: 100%;
        margin: 0 40px;
        margin-bottom: 39px;
        height: 19px;
        border-bottom: 2px dashed #CCD0D7;

        .error-tip{
          display: inline-block;
          padding: 0 20px;
          height: 40px;
          line-height: 40px;
          font-size: 24px;
          background: white;
          color: #CCD0D7;
        }
      }
    }
  }
}
</style>
