/* In Task 9, you will be adding code this combined
 * Surface and Vertex shader to inflate a model along
 * its vertex normal direction (as in the previous lab
 * but this time supporting surface shaders)
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task9/InflationShader"
{
   // Unity Inspector properties
    Properties
    {
        /*******
         * TODO: Add the Texture for our mesh here
         *******/
         
         _MainTexture ("Main Texture", 2D) = "white" {}

        // The amount to inflate the mesh along it's normals
        _InflationFactor ("Inflation Factor", Range(-.1, .5)) = 0.1
    }

    // Our Shader Program
    SubShader
    {

        // The first pass will be a surface shader which draws
        // the original model
        CGPROGRAM
        // Define a surface shader in the surf function using
        // the lambert lighting model
        /*******
         * TODO: Reference our vertex shader using the format vertex:shaderfunctionname
         *******/
        #pragma surface surf Lambert vertex:vert

        // The input structure to our surface function
        struct Input
        {
            /*******
             * TODO: To ensure that texture tiling and offset values
             * get applied to the UV coordinates, we need to append
             * the texture name to the end of the uv coordinates, e.g
             * if our texture is called _MainTex, it should be uv_MainTex
             * or if our texture is called myTex, it should be uvmyTex
             *******/
            float2 uv_MainTexture;
        };

        /*******
         * TODO: Add the sampler2D for our main texture
         *******/
         sampler2D _MainTexture;

        // The uniform variable for our inflation factor
        float _InflationFactor;

        // The definition of our Surface Output structure for reference
        /*
        struct SurfaceOutput
        {
            fixed3 Albedo;  // diffuse color
            fixed3 Normal;  // tangent space normal, if written
            fixed3 Emission;
            half Specular;  // specular power in 0..1 range
            fixed Gloss;    // specular intensity
            fixed Alpha;    // alpha for transparencies
        };
        */

        // The definition of our appdata_base structure for reference
        /*
        struct appdata_base {
            float4 vertex : POSITION;
            float3 normal : NORMAL;
            float4 texcoord : TEXCOORD0;
            UNITY_VERTEX_INPUT_INSTANCE_ID
        };
        */

        // The vertex shader, reads/writes to a variable of type appdata_base
        // called v
        void vert (inout appdata_base v) {
            // update v's vertex position by shifting it along the normal direction
            // multiplied by the inflation factor (we're expecting a float4 out
            // so just add a 1 to the end of the float 3 we get from multiplying by
            // the float3 normal)
            v.vertex = float4(v.vertex + v.normal * _InflationFactor, 1);

        }

        // The surface shader, takes a variable of type Input named IN
        // and reads/writes to a variable of type SurfaceOutput called o
        void surf (Input IN, inout SurfaceOutput o)
        {
            /*******
             * TODO: Set surface output Albedo (Diffuse) colour by extracting
             * colour from texture using the tex2D function
             *******/
             o.Albedo = tex2D(_MainTexture, IN.uv_MainTexture).rgb;
        }
        ENDCG
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}
