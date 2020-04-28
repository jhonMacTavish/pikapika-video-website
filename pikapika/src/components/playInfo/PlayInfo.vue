<template>
  <div class="page-content">
    <router-view/>
    <div class="playInfo-content">
        <Ad/>
        <Episode/>
        <Block title="推荐"/>
        <Comment/>
    </div>
  </div>
</template>

<script>
import Ad from "../ad/Ad";
import Block from '../block/Block'
import Comment from '../comment/Comment'
import Episode from '../common/episode/Episode'

export default {
  name: "PlayInfo",
  data() {
    return {};
  },
  computed: {},
  watch: {},
  methods: {},
  components: {Ad,Block,Comment,Episode}
};
</script>

<style lang='less' scoped>
.page-content {
  width: 100% !important;
  margin-top: -20px;
  //   margin-left: -180px;
  //   margin-right: -180px;
  
  .playInfo-content{
    margin: 0 auto;
    width: 1160px;
  }
}
</style>
