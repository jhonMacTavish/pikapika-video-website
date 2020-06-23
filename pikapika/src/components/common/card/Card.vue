<template>
  <div class="card-box">
    <!-- <div class="card-content"> -->
    <router-link
      :to="{path:'/playinfo',query:{type_id:listItem.type_id,film_id:listItem.film_id}}"
      target="_blank"
      tag="a"
      class="card-content"
    >
      <!-- <img :src="listItem.imgSrc" :title="listItem.name" /> -->
      <img
        :src="listItem.imgSrc"
        :title="listItem.name"
      />

      <!-- <p class="name">{{listItem.name}}</p> -->
      <p class="name">
        {{listItem.name}}
      </p>

      <p v-if="listItem.type_id!=3" class="chapter">
        <span>
          {{listItem.is_ended==1?"全":"更新至"}}
        </span>
        <span :style="listItem.is_ended!=1?'color: #ff8eb3;':''">{{listItem.episodes}}话</span>
      </p>

      <p v-else class="chapter">{{listItem.VGA==1?"BD720P":"BD1080P"}}</p>
      <!-- <p class="chapter">{{listItem.status==2?"全":"更新至"}}{{listItem.episodes}}话</p> -->
    </router-link>
    <!-- </div> -->
  </div>
</template>

<script>
export default {
  name: "Card",
  props: {
    listItem: {}
  },
  data() {
    return {};
  },
  methods: {
    // selectedObj() {
    //   this.$store.commit("UpdateSelectedObj", listItem);
    // }
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
    display: inline-block;
    position: relative;
    width: 170px;
    height: 100%;
    cursor: pointer;
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

    .name {
      position: absolute;
      // font-weight: 400;
      top: 228px;
    }

    .chapter {
      position: absolute;
      bottom: 0;
      width: 100%;
      background: white;
      color: #ff8eb3;
      span {
        color: gray;
      }
    }
  }

  .card-content:hover {
    .name {
      color: #00a1d6;
    }
  }
}
</style>