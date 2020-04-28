<template>
  <div id="navbar" class="navbar-box">
    <!-- <div class="navbar-slider" :style="{left:sliderPos+'px'}"></div> -->
    <ul>
      <li v-for="(item) in navList" :key="item.id">
        <!-- <router-link :to="item.name"> -->
        <router-link
          :to="item.id>1? (item.id<6? {name:'general', params:{id:item.name}}:{name:'list', params:{id:item.name}}):{name:item.name}"
        >
          <!-- <svg
            t="1587369456571"
            class="icon"
            viewBox="0 0 1024 1024"
            version="1.1"
            xmlns="http://www.w3.org/2000/svg"
            p-id="2090"
            width="26"
            height="26"
          >
            <path
              d="M509.1 265.6l-61.9-61.9c-84.7-84.7-222.2-84.7-306.9 0-84.7 84.7-84.7 222.2 0 306.9l61.9 61.9 285.9 285.9c11.6 11.6 30.3 11.6 41.9 0l286-285.9 61.9-61.9c84.7-84.7 84.7-222.2 0-306.9-84.7-84.7-222.2-84.7-306.9 0l-61.9 61.9z"
              fill="#CE3604"
              p-id="2091"
            />
            <path
              d="M486 814.4l285.9-285.9 61.9-61.9c46.3-46.3 67.3-108.2 63-168.7-5.9-83.8-73.4-151.3-157.2-157.2-60.5-4.3-122.5 16.7-168.7 63L509 265.6l-44-44-17.9-17.9c-84.7-84.7-222.2-84.7-306.9 0-84.7 84.7-84.7 222.2 0 306.9l17.9 17.9 44 44L444 814.4c11.7 11.6 30.4 11.6 42 0z"
              fill="#F25A25"
              p-id="2092"
            />
            <path
              d="M897.4 312.8c-0.1-70.5-57.1-127.4-127.6-127.5-55.6 0-111.2 21.1-153.6 63.5l-61.9 61.9-61.9-61.9c-84.7-84.7-222.2-84.7-306.9 0-84.7 84.7-84.7 222.2 0 306.9l61.9 61.9 49.3 49.3 147.4 147.4c11.6 11.6 30.3 11.6 41.9 0l285.9-285.9 61.9-61.9c42.5-42.4 63.7-98 63.6-153.7z"
              fill="#F24500"
              p-id="2093"
            />
          </svg> -->
          <div v-html="item.svg" class="svg"></div>
          <span @mouseover="setPos" @mouseout="setPos">{{item.title}}</span>
        </router-link>
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  name: "Navbar",
  data() {
    return {
      sliderPos: "30px"
    };
  },
  computed:{
    navList(){
      return this.$store.getters.navList;
    }
  },
  methods: {
    setPos(e) {
      //   let slider = document.getElementsByClassName("navbar-slider")[0];
      //   switch(e.type){
      //       case "mouseover":
      //           console.log(e.target);
      //           this.sliderPos = e.target.style.left;
      //           break;
      //       case "mouseout":
      //           this.sliderPos = '30px';
      //           break;
      //       default:
      //           break;
      //   }
      //   console.log(this.sliderPos);
    }
  }
};
</script>

<style lang="less" scoped>
.navbar-box {
  position: relative;
  margin: 0 auto;
  width: 1160px;
  margin-top: 10px;
  height: 50px;
  line-height: 50px;
  border-bottom: 1px solid rgba(0, 0, 0, 0.1);
  ul {
    display: flex;
    justify-content: space-between;
    li {
      div.svg{
        display: inline-block;
      }

      span {
        position: relative;
        margin-left: 10px;
        top: -6px;
        font-size: 18px;
      }
    }

    li:hover {
      color: #00a1d6;
      cursor: pointer;
      span::after {
        content: "";
        position: absolute;
        width: 100%;
        height: 2px;
        top: 40px;
        left: 0px;
        background: #00a1d6;
      }
    }
  }

  .navbar-slider {
    position: absolute;
    top: 47px;
    left: 30px;
    width: 36px;
    height: 2px;
    background: #00a1d6;
  }
}
</style>