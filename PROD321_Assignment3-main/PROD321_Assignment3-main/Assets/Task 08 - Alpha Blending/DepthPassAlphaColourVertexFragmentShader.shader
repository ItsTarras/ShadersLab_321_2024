/* In Task 8, you will be adding code this vertex/fragment
 * shader to support alpha transparency and an additional
 * depth pass to stop self occlusion overlapping
 *
 * PROD321 - Interactive Computer Graphics and Animation 
 * Copyright 2023, University of Canterbury
 * Written by Adrian Clark
 */

Shader "Assignment3/Task8/DepthPassAlphaColourVertexFragmentShader"
{
    // Unity Inspector properties
    Properties
    {
        // The diffuse colour of our surface
        _Color ("Color", Color) = (1,1,1,.5)
    }

    // Our Shader Program
    SubShader
    {

        // The depth writing pass
        Pass {
            /*******
             * TODO: Turn on ZWriting
             *******/
             ZWrite On
            /*******
             * TODO: Disable writing to the frame buffer
             * using ColorMask 0
             *******/
             ColorMask 0
        }

        Pass
        {
            /*******
             * TODO: Define Blend Function
             *******/
             Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            // Define a vertex shader in the vert function
            #pragma vertex vert
            // Define a fragment shader in the frag function
            #pragma fragment frag

            // Include UnityCG.cginc for helpful functions
            #include "UnityCG.cginc"

            // The uniform variable for our diffuse colour property
            fixed4 _Color;

            // The vertex function, takes a variable of type float4 named
            // vertex and semantically tagged POSITION (the model space vertex position)
            // and returns a float4 semantically tagged with SV_POSITION for
            // the homogeneous clip space vertex position
            float4 vert (float4 vertex : POSITION) : SV_POSITION
            {
                // Return the transformed vertex from model space
                // to homogenous clip space
                return UnityObjectToClipPos(vertex);
            }

            // The fragment function, takes a variable of type float4 named
            // i and semantically tagged SV_POSITION (the homogeneous clip space
            // vertex position) and returns a colour semantically tagged with SV_Target
            fixed4 frag (float4 i : SV_POSITION) : SV_Target
            {
                // Return the colour
                return _Color;
            }
            ENDCG
        }
    }

    // Fallback to the Diffuse lighting model
    FallBack "Diffuse"
}
