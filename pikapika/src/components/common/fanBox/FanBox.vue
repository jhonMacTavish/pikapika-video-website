<template>
  <div class="fanBox-box">
    <router-link
      :to="{path:'/playinfo',query:{type_id:listItem.type_id,film_id:listItem.film_id}}"
      target="_blank"
      tag="a"
    >
      <img :src="listItem.imgSrc" alt />
    </router-link>
    <div class="desc">
      <router-link
        :to="{path:'/playinfo',query:{type_id:listItem.type_id,film_id:listItem.film_id}}"
        target="_blank"
        tag="a"
      >
        <span :title="listItem.name">{{listItem.name}}</span>
      </router-link>
      <p>
        更新至
        <router-link
          :to="{path:`/playinfo/play/${listItem.type_id}/${listItem.film_id}/${listItem.episodes}`}"
          target="_blank"
          tag="a"
        >{{listItem.episodes}}话</router-link>
      </p>
    </div>
  </div>
</template>

<script>
export default {
  name: "FanBox",
  props: {
    listItem: {
      type_id: null,
      film_id: null,
      name: "",
      episodes: "",
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

  img:hover {
    cursor: pointer;
  }

  .desc {
    width: 100%;
    height: 100%;
    position: relative;
    font-size: 12px;
    overflow: hidden;
    a {
      position: absolute;
      top: 0;
      span {
        display: inline-block;
        width: 100%;
        height: 80px;
        line-height: 18px;
      }

      span:hover {
        color: #00a1d6;
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
