<template>
  <div class="findPsw-box">
    <div class="header-tip">
      <span @click="turnLogin">登录</span>
      <span>></span>
      <span>忘记密码</span>
    </div>
    <div class="step-wrap">
      <div class="step-line">
        <div @click="$router.push({name:'verify'})" class="verify active">
          <span class="step-icon">1</span>
          <div class="step-title">确认账号</div>
        </div>
        <div @click="$router.push({name:'reset'})" class="reset">
          <span class="step-icon">2</span>
          <div class="step-title">重置密码</div>
        </div>
        <div @click="$router.push({name:'success'})" class="success">
          <span class="step-icon">3</span>
          <div class="step-title">重置成功</div>
        </div>
      </div>
      <div class="form">
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "FindPsw",
  data() {
    return {};
  },
  computed: {},
  watch: {},
  methods: {
    turnLogin() {
      this.$router.push({ name: "login" });
    }
  },
  components: {}
};
</script>

<style lang='less' scoped>
.findPsw-box {
  margin: 60px auto;
  margin-top: 40px;
  width: 980px;
  .header-tip {
    span {
      font-size: 14px;
    }

    span:nth-child(0n + 1) {
      font-weight: bolder;
      cursor: pointer;
    }
  }

  .step-wrap {
    margin-top: 24px;
    width: 100%;
    .step-line {
      margin: 0 auto;
      position: relative;
      width: 500px;
      height: 12px;
      border-bottom: 2px solid #e5e9ef;
      margin-bottom: 14px;
        color: #ccd0d7;

      .active {
        color: #fb7299 !important;
        span{
          border-color: #fb7299;
        }
      }

      div {
        padding: 0 10px;
        display: inline-block;
        // background: blueviolet;
        // padding: 0 10px;
        background: white;
        cursor: pointer;

        .step-icon {
          font-size: 12px;
          display: inline-block;
          background-color: #fff;
          width: 20px;
          height: 20px;
          font-family: Arial;
          font-weight: 700;
          border-radius: 50%;
          line-height: 20px;
          border: 2px solid #ccd0d7;
          //   margin-right:10px;
          text-align: center;
          margin-right: -10px;
        }

        .step-title {
          position: relative;
          display: inline-block;
          top: 2px;
          height: 20px;
          line-height: 20px;
          font-size: 18px;
        }
      }

      div:nth-child(0n + 1) {
        position: absolute;
        left: 0;
      }
      div:nth-child(0n + 2) {
        position: relative;
        left: 50%;
        transform: translateX(-50%);
      }
      div:nth-child(0n + 3) {
        position: absolute;
        right: 0;
      }
    }

    .form {
      margin: 65px auto;
      width: 500px;
    }
  }
}
</style>
