<template>
  <div class="card-box">
    <!-- <div class="card-content"> -->
    <router-link
      :to="{path:'/playinfo',query:{t_id:listItem.t_id,v_id:listItem.v_id}}"
      target="_blank"
      tag="a"
      class="card-content"
    >
      <!-- <img :src="listItem.b_imgSrc" :title="listItem.b_name" /> -->
      <img
        :src="listItem.t_id==1?
          listItem.b_imgSrc:listItem.t_id==2?
          listItem.g_imgSrc:listItem.t_id==3?
          listItem.th_imgSrc:listItem.f_imgSrc"
        :title="listItem.b_name"
      />

      <!-- <p class="name">{{listItem.b_name}}</p> -->
      <p class="name">
        {{listItem.t_id==1?
        listItem.b_name:listItem.t_id==2?
        listItem.g_name:listItem.t_id==3?
        listItem.th_name:listItem.f_name}}
      </p>

      <p v-if="listItem.t_id!=3" class="chapter">
        <span>
          {{(listItem.t_id==1?
          listItem.b_status:listItem.t_id==2?
          listItem.g_status:listItem.f_status)==2?"全":"更新至"}}
        </span>
        {{listItem.t_id==1?
        listItem.b_episodes:listItem.t_id==2?
        listItem.g_episodes:listItem.f_episodes}}话
      </p>

      <p v-else class="chapter">{{listItem.th_VGA==1?"BD720P":"BD1080P"}}</p>
      <!-- <p class="chapter">{{listItem.b_status==2?"全":"更新至"}}{{listItem.b_episodes}}话</p> -->
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