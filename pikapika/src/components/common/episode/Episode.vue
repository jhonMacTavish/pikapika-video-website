<template>
  <div class="episode-box">
    <div class="tip">选集</div>
    <div class="wrap">
      <ul>
        <li v-for="item in 70" :key="item">
          <el-button class="button-style" type="primary" size="small" @click="$router.push({name:'play'})" plain>第{{item}}话</el-button>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  name: "Episode",
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
.episode-box {
  margin-top: 10px;

  .tip {
    padding-bottom: 2px;
    border-bottom: 2px solid #00a1d6;
  }
  .wrap {
    position: relative;

    ul {
      margin: 10px 0;
      width: 100%;
      height: 294px;
      overflow: auto;
      li {
        float: left;
        display: inline-block;
        
          margin-bottom: 10px;
          margin-right: 15px;
        .button-style {
          width: 100px;
        }
      }

      li:nth-child(10n+0){
          margin-right: 0;
        }
    }

    ul::after {
      content: "";
      display: block;
      clear: both;
      visibility: hidden;
    }
  }
}
</style>
