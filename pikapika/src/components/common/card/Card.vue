<template>
  <div class="card-box">
    <div class="card-content">
      <img :src="listItem.imgSrc+listItem.id+'.jpg'" :title="listItem.title"/>
      <p class="name">{{listItem.title}}</p>
      <p class="chapter">更新至{{listItem.latestChapter}}话</p>
    </div>
  </div>
</template>

<script>
export default {
  name: "Card",
  props:{
    listItem: {
      id: 0,
      title: "",
      latestChapter: "",
      imgSrc: ""
    }
  },
  data() {
    return {};
  }
};
</script>

<style lang="less" scoped>
.card-box {
  display: inline-block;
  float: left;
  margin-top: 24px;
  margin-right: 28px;
  // width: 14%;
  height: 266px;
  // display: flex;
  // flex-direction: column;
  font-size: 12px;
  overflow: hidden;
  .card-content {
    position: relative;
    width: 170px;
    height: 100%;
    img {
      display: inline-block;
      width: 170px;
      height: 224px;
      border-radius: 3px;
      // background: turquoise;
      background: url(https://i.pximg.net/img-master/img/2020/04/26/19/27/34/81080486_p0_master1200.jpg);
      background-size: contain;
      background-repeat: no-repeat;
      background-position: center;
      overflow: hidden;
    }
    p {
      margin-top: 4px;
    }

    .name{
      position: absolute;
      top: 228px;
    }

    .chapter {
      position: absolute;
      bottom: 0;
      width: 100%;
      background: white;
      color: red;
    }
  }
}
</style>