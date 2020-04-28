<template>
  <div class="fanBox-box">
    <img
      :src="listItem.imgSrc"
      alt
    />
    <div class="desc">
      <a href="javascript:;">
        <span>{{listItem.title}}</span>
      </a>
      <p>
        更新至
        <a href="javascript:;">{{listItem.latestChapter}}话</a>
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: "FanBox",
  props: {
    listItem: {
      id: 0,
      title: "",
      latestChapter: "",
      imgSrc: ""
    }
  },
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
.fanBox-box {
  float: left;
  width: 170px;
  height: 72px;
  margin-top: 18px;
  margin-bottom: 18px;
  margin-right: 44px;
  display: flex;
  justify-content: space-between;
  img {
    display: inline-block;
    margin-right: 12px;
    min-width: 72px;
    height: 72px;
    background: paleturquoise;
    border-radius: 5px;
  }

  .desc {
    width: 100%;
    height: 100%;
    position: relative;
    font-size: 12px;
    overflow: hidden;
    a{
      position: absolute;
      top: 0;
      span{
        line-height: 18px;
      }
    }
    
    p {
      width: 100%;
      height: 18px;
      line-height: 18px;
      background: white;
      position: absolute;
      bottom: 0;
      color: #aaaaaa;
      a {
        display: inline-block;
        border-radius: 9px;
        vertical-align: top;
        text-align: center;
        padding: 0 4px;
        height: 18px;
        line-height: 18px;
        min-width: 28px;
        max-width: 80px;
        -o-text-overflow: ellipsis;
        text-overflow: ellipsis;
        overflow: hidden;
        color: #fff;
        margin-left: 5px;
        background: #ff8eb3;
        cursor: pointer;
      }
    }
  }
}
</style>
