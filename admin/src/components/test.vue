<template>
  <div>
    <div class="block">
      <span class="demonstration">默认</span>
      <el-date-picker v-model="value1" type="date" placeholder="选择日期" value-format="yyyy-MM-dd"></el-date-picker>
    </div>
    
  </div>
</template>

<script>
export default {
  data() {
    return {
      value1: "2020-05-01",
      value2: ""
    };
  },
  mounted(){
    console.log([].join(""), )
  }
};
</script>