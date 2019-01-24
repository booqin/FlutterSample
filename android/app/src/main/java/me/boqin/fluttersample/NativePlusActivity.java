package me.boqin.fluttersample;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

/**
 *
 * Created by BoQin on 2019/1/24.
 * Modified by BoQin
 *
 * @Version
 */
public class NativePlusActivity extends Activity {

    public static final String TAG = NativePlusActivity.class.getSimpleName();

    private Button mButton;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        String param = getIntent().getStringExtra(TAG);

        setContentView(R.layout.activity_main);

        mButton = findViewById(R.id.button);
        mButton.setText(param);
        mButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });

    }

}
