package com.example.activitydemo;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;

public class MainActivity2 extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);

        TextView text = findViewById(R.id.textView02);
        Intent intent1g = getIntent();
        String temp = intent1g.getStringExtra("Key00");
        text.setText(temp);
        Log.d("debug101", "MainActivity_2 onCreate");
    }

    @Override
    protected void onStart(){
        super.onStart();
        Log.d("debug101", "MainActivity_2 onStart");
    }

    @Override
    protected void onResume(){
        super.onResume();
        Log.d("debug101", "MainActivity_2 onResume");
    }

    @Override
    protected void onPause(){
        super.onPause();
        Log.d("debug101", "MainActivity_2 onPause");
    }

    @Override
    protected void onStop(){
        super.onStop();
        Log.d("debug101", "MainActivity_2 onStop");
    }

    @Override
    protected void onRestart(){
        super.onRestart();
        Log.d("debug101", "MainActivity_2 onRestart");
    }

    @Override
    protected void onDestroy(){
        super.onDestroy();
        Log.d("debug101", "MainActivity_2 onDestroy");
    }

    @Override
    protected void onRestoreInstanceState(@NonNull Bundle savedInstanceState){
        super.onRestoreInstanceState(savedInstanceState);
        Log.d("debug101", "MainActivity_2 onRestoreInstanceState");
    }

    @Override
    protected void onSaveInstanceState(@NonNull Bundle outState){
        super.onSaveInstanceState(outState);
        Log.d("debug101", "MainActivity_2 onSaveInstanceState");
    }
}