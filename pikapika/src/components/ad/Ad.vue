<template>
  <div class="ad-box">
    <a
      :href="ad.url"
      target="_black"
    >
      <img :src="ad.imgSrc" :alt="ad.brand" />
    </a>
  </div>
</template>

<script>
export default {
  name: "Ad",
  data() {
    return {
      browserWidth: 0,
      ad:{}
    };
  },
  created() {
    this.fetch();
  },
  methods: {
    async fetch() {
      const res = await this.$http.get("/ads");
      let ads = res.data.list;
      let index = Math.floor(Math.random() * ads.length);
      this.ad = ads[index];
    }
  }
};
</script>

<style lang="less" scoped>
.ad-box {
  margin-top: 20px;
  width: 100%;
  a {
    width: 100%;
    img {
      width: 100%;
      overflow: auto;
    }
  }
}
</style>